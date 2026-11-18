package model;

/** Dados exibidos nas listas do administrador. Nunca contém a senha. */
public record CustomerAccount(int id, String nome, String sexo, String email) {
}
