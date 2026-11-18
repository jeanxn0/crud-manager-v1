package model;

import java.time.*;
import java.math.BigDecimal;

public record Game(int id, String titulo, String descricao, LocalDate data_lancamento, BigDecimal preco, Integer usuario_id) {
    public int getId() { return id; }
    public String getTitulo() { return titulo; }
    public String getDescricao() { return descricao; }
    public LocalDate getData_lancamento() { return data_lancamento; }
    public BigDecimal getPreco() { return preco; }
    public Integer getUsuario_id() { return usuario_id; }
}
