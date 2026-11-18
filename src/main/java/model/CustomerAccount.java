package model;


public record CustomerAccount(int id, String nome, String sexo, String email) {
    public int getId() { return id; }
    public String getNome() { return nome; }
    public String getSexo() { return sexo; }
    public String getEmail() { return email; }
}
