package model;

import java.math.BigDecimal;

public record DashboardStats(long games, long orders, long pending, long accounts,
                             long users, long companies, long posts, BigDecimal revenue) {}
