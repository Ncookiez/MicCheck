package triepackage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class loadTrie {
	
	static char[] punctuation = {',', '.', '/', '-', '&', '!', '?', '_'};

	public static void main(String[] args) throws Exception {
		Trie trie = new Trie();
		
		// Creating connection to database:
		String url = "jdbc:mysql://173.194.107.58/MicCheck";
		String uid = "Ncookie";
		String pw = "miccheck";
		System.out.println("Connecting to database.");
		Connection con = DriverManager.getConnection(url, uid, pw);
		
		String fileName = "WebContent/searchTrie.xml";
		
		Statement stmnt = con.createStatement();
		ResultSet rst;
		
		try{
			rst = stmnt.executeQuery("SELECT pID, title, category, cond, brand, year, tags FROM Instrument");
			while(rst.next()){
				int pID = rst.getInt(1);
				String[] title = strip(rst.getString(2)).split(" ");
				String[] cat = strip(rst.getString(3)).split(" ");
				String[] brand = strip(rst.getString(5)).split(" ");
				String[] tags = strip(rst.getString(7)).split(" ");
				
				for(String str : title) trie.add(str, pID);
				for(String str : cat) trie.add(str, pID);
				for(String str : brand) trie.add(str, pID);
				for(String str : tags) trie.add(str, pID);
				
				int cond = rst.getInt(4);
				trie.add((cond == 1 ? "new" : "used"), pID);
				int year = rst.getInt(6);
				trie.add(""+year, pID);
			}
			System.out.println("Writing trie to "+ fileName);
			trie.writeTrie(fileName); //write the trie to an xml file
		}catch(Exception e){
			e.printStackTrace();
		}
		con.close();
		
		System.out.println("done.");
	}
	
	static String strip(String str){
		if(str==null) return "";
		str = str.toLowerCase();
		for(int c = 0; c < str.length(); c++){
			//Replace punctuation
			for(char punct : punctuation){
				str = str.replace(punct, ' ');
			}
		}
		return str;
	}

}
