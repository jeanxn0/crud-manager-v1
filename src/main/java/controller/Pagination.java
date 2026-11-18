package controller;

import jakarta.servlet.http.HttpServletRequest;
import java.util.List;

 



final class Pagination {

    private static final int PAGE_SIZE = 10;

    private Pagination() {
         
    }

    static void apply(HttpServletRequest request, String attributeName, List<?> items) {
        int totalPages = Math.max(1, (items.size() + PAGE_SIZE - 1) / PAGE_SIZE);
        int requestedPage = 1;

        try {
            requestedPage = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException ignored) {
             
        }

        int currentPage = Math.min(totalPages, Math.max(1, requestedPage));
        int startIndex = (currentPage - 1) * PAGE_SIZE;
        int endIndex = Math.min(startIndex + PAGE_SIZE, items.size());

        request.setAttribute(attributeName, items.subList(startIndex, endIndex));
        request.setAttribute("paginationPath", request.getServletPath());
        request.setAttribute("itemCount", items.size());
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
    }
}
