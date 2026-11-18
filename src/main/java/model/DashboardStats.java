package model;

import java.math.BigDecimal;

public record DashboardStats(long games, long orders, long pending, long accounts,
                             long users, long companies, long posts, BigDecimal revenue) {
    public long getGames() { return games; }
    public long getOrders() { return orders; }
    public long getPending() { return pending; }
    public long getAccounts() { return accounts; }
    public long getUsers() { return users; }
    public long getCompanies() { return companies; }
    public long getPosts() { return posts; }
    public BigDecimal getRevenue() { return revenue; }
}
