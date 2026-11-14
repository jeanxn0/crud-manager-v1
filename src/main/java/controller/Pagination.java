package controller;

import jakarta.servlet.http.HttpServletRequest;
import java.util.List;

final class Pagination {
    private static final int PAGE_SIZE = 10;

    static void apply(HttpServletRequest request, String name, List<?> rows) {
        int total = Math.max(1, (rows.size() + PAGE_SIZE - 1) / PAGE_SIZE);
        int requested = 1;
        try {
            requested = Integer.parseInt(request.getParameter("page"));
        } catch (NumberFormatException ignored) {
            // Missing or invalid page numbers use the first page.
        }
        int page = Math.min(total, Math.max(1, requested));
        int start = (page - 1) * PAGE_SIZE;
        request.setAttribute(name, rows.subList(start, Math.min(start + PAGE_SIZE, rows.size())));
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", total);
    }
}
