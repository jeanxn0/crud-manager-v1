package model;

import java.util.Calendar;
import java.util.Date;

/** Publicacao associada a uma conta da loja ou a um usuario interno antigo. */
public class Post {
    private int id;
    private String content;
    private Date postDate;
    private User user;
    private Integer accountId;
    private CustomerAccount account;

    public Post() {
        this(0);
    }

    public Post(int id) {
        this.id = id;
        this.content = "";
        this.postDate = Calendar.getInstance().getTime();
    }

    public int getId() { return id; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Date getPostDate() { return postDate; }
    public void setPostDate(Date postDate) { this.postDate = postDate; }

    /** Mantido para apresentar o autor de publicacoes antigas. */
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Integer getAccountId() { return accountId; }
    public void setAccountId(Integer accountId) { this.accountId = accountId; }
    public CustomerAccount getAccount() { return account; }
    public void setAccount(CustomerAccount account) { this.account = account; }
}
