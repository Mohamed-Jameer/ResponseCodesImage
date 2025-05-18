package com.example.demo.controller;

import com.example.demo.entity.ResponseCodeList;
import com.example.demo.entity.User;
import com.example.demo.service.ResponseCodeListService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Controller
public class ListController {
    @Autowired
    private ResponseCodeListService listService;

    @GetMapping("/search")
    public String searchPage(@RequestParam(required = false) String filter, Model model) {
        List<String> imageUrls = new ArrayList<>();
        if (filter != null && !filter.isEmpty()) {
            List<String> validCodes = getValidCodes();

            for (String code : validCodes) {
                if (matchesFilter(code, filter)) {
                    imageUrls.add("https://http.dog/" + code + ".jpg");
                }
            }
        }

        model.addAttribute("imageUrls", imageUrls);
        model.addAttribute("filter", filter);
        return "search";
    }

    @PostMapping("/search/filter")
    @ResponseBody
    public List<String> filterResponseCodes(@RequestParam String filter) {
        List<String> validCodes = getValidCodes();
        List<String> matchedUrls = new ArrayList<>();

        for (String code : validCodes) {
            if (matchesFilter(code, filter)) {
                matchedUrls.add("https://http.dog/" + code + ".jpg");
            }
        }

        return matchedUrls;
    }

    @PostMapping("/search/save")
    public String saveList(@RequestParam String name,
                           @RequestParam String filter,
                           HttpSession session) {
        User user = (User) session.getAttribute("user");
        if(user == null) return "redirect:/login";

        List<String> responseCodes = new ArrayList<>();
        List<String> imageUrls = new ArrayList<>();

        for (String code : getValidCodes()) {
            if(matchesFilter(code, filter)) {
                responseCodes.add(code);
                imageUrls.add("https://http.dog/" + code + ".jpg");
            }
        }

        ResponseCodeList list = new ResponseCodeList();
        list.setName(name);
        list.setCreatedAt(LocalDateTime.now());
        list.setResponseCodes(responseCodes);
        list.setImageUrls(imageUrls);
        list.setUser(user);

        listService.save(list);

        return "redirect:/lists";
    }

    @GetMapping("/lists")
    public String listsPage(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if(user == null) return "redirect:/login";

        var lists = listService.findByUser(user);
        model.addAttribute("lists", lists);

        return "lists";
    }

    @GetMapping("/lists/{id}")
    public String viewList(@PathVariable Long id, Model model, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        var list = listService.findById(id);
        if (list == null || !list.getUser().getId().equals(user.getId())) {
            return "redirect:/lists";
        }

        List<String> validHttpCodes = getValidCodes();

        // Prepare a list of Map entries (code, url) for JSP rendering
        List<Map.Entry<String, String>> codeAndUrls = list.getImageUrls().stream()
                .filter(url -> validHttpCodes.contains(extractCodeFromUrl(url)))
                .map(url -> new AbstractMap.SimpleEntry<>(extractCodeFromUrl(url), url))
                .collect(Collectors.toList());

        model.addAttribute("list", list);
        model.addAttribute("codeAndUrls", codeAndUrls);

        return "list_view"; // JSP view
    }

    @PostMapping("/lists/delete/{id}")
    public String deleteList(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if(user == null) return "redirect:/login";

        var list = listService.findById(id);
        if(list != null && list.getUser().getId().equals(user.getId())) {
            listService.deleteById(id);
        }
        return "redirect:/lists";
    }

    @PostMapping("/search/save-single")
    public String saveSingleImage(@RequestParam String filter,
                                  @RequestParam String imageUrl,
                                  HttpSession session,
                                  RedirectAttributes redirectAttrs) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        String code = imageUrl.substring(imageUrl.lastIndexOf("/") + 1, imageUrl.lastIndexOf("."));
        String name = "Auto List for " + filter;

        List<ResponseCodeList> userLists = listService.findByUser(user);
        ResponseCodeList list = userLists.stream()
                .filter(l -> l.getName().equals(name))
                .findFirst()
                .orElse(null);

        if (list == null) {
            list = new ResponseCodeList();
            list.setName(name);
            list.setCreatedAt(LocalDateTime.now());
            list.setResponseCodes(new ArrayList<>());
            list.setImageUrls(new ArrayList<>());
            list.setUser(user);
        }

        if (!list.getResponseCodes().contains(code)) {
            list.getResponseCodes().add(code);
            list.getImageUrls().add(imageUrl);
            listService.save(list);
            redirectAttrs.addFlashAttribute("message", "Image added successfully!");
        } else {
            redirectAttrs.addFlashAttribute("message", "Image already in list.");
        }

        return "redirect:/search?filter=" + filter;
    }

    // Utility methods

    private List<String> getValidCodes() {
        return Arrays.asList(
                "100","101","102","103",
                "200","201","202","203","204","205","206","207","208","226",
                "300","301","302","303","304","305","307","308",
                "400","401","402","403","404","405","406","407","408","409",
                "410","411","412","413","414","415","416","417","418",
                "421","422","423","424","425","426","428","429","431","451",
                "500","501","502","503","504","505","506","507","508","510","511"
        );
    }

    private boolean matchesFilter(String code, String filter) {
        if (filter == null || filter.isEmpty()) return false;

        if (filter.matches("\\d")) {
            return code.startsWith(filter); // e.g. "2"
        } else if (filter.matches("\\dxx")) {
            return code.startsWith(filter.substring(0, 1)); // e.g. "2xx"
        } else if (filter.matches("\\d{2}x")) {
            return code.startsWith(filter.substring(0, 2)); // e.g. "20x"
        } else if (filter.matches("\\d{3}")) {
            return code.equals(filter); // e.g. "203"
        }

        return false;
    }

    private String extractCodeFromUrl(String url) {
        String[] parts = url.split("/");
        return parts[parts.length - 1].replaceAll("\\D", "");
    }
}
