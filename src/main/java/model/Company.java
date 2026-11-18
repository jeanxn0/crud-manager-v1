package model;

import java.util.Date;

/** Cadastro de empresa com responsavel da loja ou legado interno. */
public class Company {
    private int id;
    private String name;
    private String role;
    private Date start;
    private Date end;
    private User user;
    private Integer accountId;
    private CustomerAccount account;

    public Company() {
    }

    public Company(int id) {
        this.id = id;
    }

    public int getId() { return id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public Date getStart() { return start; }
    public void setStart(Date start) { this.start = start; }
    public Date getEnd() { return end; }
    public void setEnd(Date end) { this.end = end; }
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
    public Integer getAccountId() { return accountId; }
    public void setAccountId(Integer accountId) { this.accountId = accountId; }
    public CustomerAccount getAccount() { return account; }
    public void setAccount(CustomerAccount account) { this.account = account; }
}
