package model.dao;

import java.util.List;
import java.util.Map;
import model.Sale;
import model.ModelException;

public interface SaleDAO {
    List<Sale> list() throws ModelException;
    Map<Integer, String> options() throws ModelException;
    void save(Sale item) throws ModelException;
    void delete(int id) throws ModelException;
}
