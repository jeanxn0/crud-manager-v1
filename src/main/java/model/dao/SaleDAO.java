package model.dao;

import java.util.List;
import java.util.Map;
import model.Sale;
import model.ModelException;

public interface SaleDAO {
    List<Sale> list() throws ModelException;
    List<Sale> listMine(int accountId) throws ModelException;
    Map<Integer, String> options() throws ModelException;
    Map<Integer, String> buyers() throws ModelException;
    boolean purchase(int gameId, int quantity, int accountId) throws ModelException;
    void save(Sale item) throws ModelException;
    void delete(int id) throws ModelException;
}
