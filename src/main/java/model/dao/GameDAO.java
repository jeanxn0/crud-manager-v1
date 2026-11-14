package model.dao;

import java.util.List;
import java.util.Map;
import model.Game;
import model.ModelException;

public interface GameDAO {
    List<Game> list() throws ModelException;
    Map<Integer, String> options() throws ModelException;
    Map<Integer, Integer> covers() throws ModelException;
    Map<Integer, List<String>> platforms() throws ModelException;
    void save(Game item) throws ModelException;
    void delete(int id) throws ModelException;
}
