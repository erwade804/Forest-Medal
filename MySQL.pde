import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

public class MySQL {
  private Connection connect = null;
  private Statement statement = null;
  private PreparedStatement preparedStatement = null;
  private ResultSet resultSet = null;

  MySQL() {
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      connect = DriverManager.getConnection("jdbc:mysql://localhost/ForestMedal?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "#Jerry123");
    }
    catch(Exception e) {
    }
  }

  void saveNPC(npc np) {
    try {
      String query = "INSERT INTO NPC (ID, MAPX, MAPY, LOCX, LOCY, SPRITE, text, BATTLE) Values ("+np.number+", "+(int)np.mapNumber.x+", "+(int)np.mapNumber.y;
      query = query+", "+(int)np.location.x+", "+(int)np.location.y+", "+np.spriteIndex+", '"+np.getText()+"', 0);";
      Statement st = connect.createStatement();
      st.executeUpdate(query);
      newString = "";
    }
    catch(Exception e) {
      e.printStackTrace();
      exit();
    }
    loadNPCs();
  }

  void setFight(int id, int fightid) {
    try {
      String query = "UPDATE NPC SET BATTLE = " + fightid + " WHERE (ID = "+id+");";
      Statement st = connect.createStatement();
      st.executeUpdate(query);
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }

  int getMaxNPC() {
    try {
      String query = "SELECT max(id) FROM NPC";
      Statement st = connect.createStatement();
      ResultSet rs = st.executeQuery(query);
      rs.next();
      return rs.getInt(1);
    }
    catch(Exception e) {
      return -2;
    }
  }
  void delNPC(int id) {
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      connect = DriverManager.getConnection("jdbc:mysql://localhost/ForestMedal?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "#Jerry123");
      String query = "DELETE FROM NPC WHERE id="+id+";"; // deleting it from the database, not to
    }
    catch(Exception e) {
      println("This npc was not deleted. Please check before accessing it again.");
    }
  }

  npc getNPC(int num) {
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      connect = DriverManager.getConnection("jdbc:mysql://localhost/ForestMedal?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "root", "#Jerry123");
      String query = "SELECT * FROM NPC WHERE id="+num+";";
      Statement st = connect.createStatement();
      ResultSet rs = st.executeQuery(query);
      rs.next();
      int id = rs.getInt("ID");
      int mapX = rs.getInt("MAPX");
      int mapY = rs.getInt("MAPY");
      int locX = rs.getInt("LOCX");
      int locY = rs.getInt("LOCY");
      int spriteID = rs.getInt("SPRITE");
      String text = rs.getString("text");
      int battle = rs.getInt("BATTLE");
      PVector m = new PVector(mapX, mapY);
      PVector l = new PVector(locX, locY);
      String[] lines = text.split("-");
      npc np = new npc(m, l, lines, id);
      PImage img = loadImage("NPC/"+spriteID+".png");
      np.setImage(img);
      if (np != null) {
        if (num > -1) {
          npcs.add(np);
        }
      }
      return np;
    }
    catch(Exception e) {
      println(e);
    }
    return null;
  }
}

void loadNPCs() {
  try {
    for (int i = 0; true; i++) {
      if (db.getNPC(i) == null) {
        break;
      }
    }
  }
  catch(Exception e) {
  }
}
