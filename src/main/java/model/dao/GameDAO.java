package model.dao;

import java.util.List;
import java.util.Map;
import model.Game;
import model.ModelException;

public interface GameDAO {
    List<Game> list() throws ModelException;
    Map<Integer, String> options() throws ModelException;
    void save(Game item) throws ModelException;
    void delete(int id) throws ModelException;
}
