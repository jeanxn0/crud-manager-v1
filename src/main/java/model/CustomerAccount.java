package model;

/**
 * Dados publicos de uma conta de cliente.
 * O hash da senha nunca e enviado para a tela administrativa.
 */
public record CustomerAccount(int id, String email) {
}
