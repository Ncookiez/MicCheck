package triepackage;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

public class Trie {
	
	public TrieNode root = new TrieNode(null, null);
	
	public Trie() {
		
	}
	
	public Trie(String file){
		buildTrie(file);
	}
	
	public void buildTrie(String file){
		try(FileReader fr = new FileReader(file); BufferedReader br = new BufferedReader(fr)){
			TrieNode parent = this.root;
			int line = 0;
			while(br.ready()){
				String str = br.readLine();
				if(line > 0){//skip null root
					String[] word = str.split(" ");
					if(str.charAt(1) != '/'){
						TrieNode newChild = new TrieNode(parent, word[0].substring(3)); //account for "<T_"
						String ids = word[1].split("'")[1];
						String[] id = ids.split(",");
						for(int i = 0; i < id.length; i++){
							try{
								newChild.ref.add(Integer.parseInt(id[i]));
							}catch(NumberFormatException e){
								
							}
						}
						parent.chld.add(newChild);
						newChild.root = parent;
						parent = newChild;
					}else{
						parent = parent.root;
						if(parent == null) break;
					}
				}
				line++;
			}
			br.close();
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	
	public void writeTrie(String file){
		try(FileOutputStream fos = new FileOutputStream(file)){
			fos.write(this.toXML().getBytes());
			fos.close();
		}catch(IOException e){
			e.printStackTrace();
		}
	}
	
	String strip(String str){
		if(str==null) return "";
		str = str.toLowerCase();
		char[] punctuation = {',', '.', '/', '-', '&', '!', '?', '_'};
		for(int c = 0; c < str.length(); c++){
			//Replace punctuation
			for(char punct : punctuation){
				str = str.replace(punct, ' ');
			}
		}
		return str;
	}
	
	public void addProduct(int pID) throws SQLException{
		try
		{	// Load driver class
			Class.forName("com.mysql.jdbc.Driver");
		}
		catch (java.lang.ClassNotFoundException e)
		{
			e.printStackTrace();
		}
		// Creating connection to database:
		String url = "jdbc:mysql://173.194.107.58/MicCheck";
		String uid = "Ncookie";
		String pw = "miccheck";
		Connection con = DriverManager.getConnection(url, uid, pw);
		
		try{
			String sql = "SELECT title, category, cond, brand, year, tags FROM Instrument WHERE pID = ?";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pID);
			ResultSet rst = pstmt.executeQuery();
			while(rst.next()){
				String[] title = this.strip(rst.getString(2)).split(" ");
				String[] cat = this.strip(rst.getString(3)).split(" ");
				String[] brand = this.strip(rst.getString(5)).split(" ");
				String[] tags = this.strip(rst.getString(7)).split(" ");
				
				for(String str : title) this.add(str, pID);
				for(String str : cat) this.add(str, pID);
				for(String str : brand) this.add(str, pID);
				for(String str : tags) this.add(str, pID);
				
				int cond = rst.getInt(4);
				this.add((cond == 1 ? "new" : "used"), pID);
				int year = rst.getInt(6);
				this.add(""+year, pID);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		con.close();
	}
	
	public void add(String str, int id) {
		str = str.toLowerCase();
		if(str.length() > 0) root.add(str, id);
	}
	
	public void remove(int id) {
		root.remove(id);
	}
	
	public int[] search(String str) {
		if(str==null || str.length() == 0) return null;
		str = str.toLowerCase();
		String[] word = str.split(" ");
		HashMap<Integer, Integer> idCount = new HashMap<Integer, Integer>();
		ArrayList<Integer> ids = new ArrayList<Integer>();
		for(int i = 0; i < word.length; i++) {
			if(word[i].length() > 0) {
				ArrayList<Integer> res = root.search(word[i]);
				if(res != null) {
					for(Integer id : res) {
						if(idCount.containsKey(id)) {
							idCount.put(id, idCount.get(id)+1);
						}else {
							idCount.put(id, 1);
							ids.add(id);
						}
					}
				}
			}
		}
		ArrayList<Result> res = new ArrayList<Result>(ids.size());
		for(Integer id : ids) {
			res.add(new Result(id, idCount.get(id)));
		}
		Collections.sort(res);
		
		int[] sortedResults = new int[res.size()];
		for(int i = 0; i < res.size(); i++) {
			sortedResults[i] = res.get(i).id;
		}
		return sortedResults;
	}
	
	@Override
	public String toString() {
		String trie = "Trie:\n";
		trie+=this.root.toString(0);
		return trie;
	}
	
	public String toXML(){
		return this.root.toXML(0);
	}
	
	class Result implements Comparable<Result>{
		
		int id, weight;
		
		public Result(int id, int weight) {
			this.id = id;
			this.weight = weight;
		}

		@Override
		public int compareTo(Result res) {
			return res.weight - this.weight;
		}
		
	}
	
	class TrieNode {
		TrieNode root;
		String str;
		ArrayList<TrieNode> chld;
		ArrayList<Integer> ref;
		
		TrieNode(TrieNode root, String str){
			this.root = root;
			this.str = str;
			this.chld = new ArrayList<TrieNode>();
			this.ref = new ArrayList<Integer>();
		}
		
		void add(String str, int id) {
			for(TrieNode chldNode : this.chld) {
				String chldStr = chldNode.str;
				int j;
				for(j = 0; (j < str.length()) && (j < chldStr.length()) && (str.charAt(j) == chldStr.charAt(j)); j++);
				//String partially matches
				if(j!=0) {
					//String matches completely
					if(j == chldStr.length()) {
						//String matches identically
						if(j == str.length() && j == chldStr.length()) {
							for(Integer n : chldNode.ref) {
								//id already exists so return
								if(id == (int) n) return;
							}
							chldNode.ref.add(id);
						}else {
							String subStr = str.substring(j, str.length());
							chldNode.add(subStr, id);
						}
					} else {//String partially matches so split node
						String s1 = chldStr.substring(0, j);
						String s2 = chldStr.substring(j, chldStr.length());
						TrieNode newNode = new TrieNode(this, s1);
						this.chld.remove(chldNode);//remove node from root children
						this.chld.add(newNode);
						newNode.chld.add(chldNode);//add node to split node children
						chldNode.root = newNode;
						chldNode.str = s2;
						if(str.length() == s1.length()) {
							//string matches the partial substring so add to new node
							newNode.ref.add(id);
						}else {
							//string still has more characters after partial match
							newNode.add(str.substring(j, str.length()), id);
						}
						
					}
					return;
				}
			}
			
			//No matches in children
			TrieNode newNode = new TrieNode(this, str);
			newNode.ref.add(id);
			this.chld.add(newNode);
		}
		
		TrieNode remove(int id) {
			ArrayList<TrieNode> removeAfter = new ArrayList<TrieNode>();
			for(TrieNode chld : this.chld) {
				TrieNode removed = chld.remove(id);
				if(removed != null) removeAfter.add(removed);
			}
			for(int i = 0; i < removeAfter.size(); i++) {
				TrieNode rem = removeAfter.get(i);
				this.chld.remove(rem); //Remove all the children that were marked for deletion
			}
			for(Integer i : this.ref) {
				if((int) i == id) {
					this.ref.remove(i);
					if(this.ref.size() == 0) {
						if(this.chld.size() == 0) {
							return this;
						}else if(this.chld.size() == 1) {
							for(TrieNode chld : this.chld) {
								this.str += chld.str;
								for(Integer j : chld.ref) {
									this.ref.add(j);
								}
								for(TrieNode n : chld.chld) {
									this.chld.add(n);
								}
								this.chld.remove(chld);
								break;
							}
						}
					}
					break;
				}
			}
			if(this.ref.size() == 0 && this.chld.size() == 0) return this;
			return null;
		}
		
		ArrayList<Integer> search(String str) {
			for(TrieNode chldNode : this.chld) {
				String chldStr = chldNode.str;
				int j;
				for(j = 0; (j < str.length()) && (j < chldStr.length()) && (str.charAt(j) == chldStr.charAt(j)); j++);
				if(j!=0) {
					if(j == chldStr.length()) {
						if(j == str.length() && j == chldStr.length()) {
							//String matches completely
							return chldNode.ref;
						}else {
							//Search child
							return chldNode.search(str.substring(j, str.length()));
						}
					}
				}
			}
			return null; //String does not exist in Trie
		}
		
		String toString(int level) {
			String refs = "";
			int count = 0;
			for(Integer i : this.ref) {
				if(count!=0) refs += ",";
				refs += (int) i;
				count++;
			}
			String children = "";
			for(TrieNode chld : this.chld) {
				children+= "\n";
				for(int t = 0; t < level+1; t++) {
					children+=" ";
					children+="|";
				}
				children+=chld.toString(level+1);
			}
			return (""+this.str + " --> " + refs + children);
		}
		
		String toXML(int level){
			String refs = "";
			int count = 0;
			for(Integer i : this.ref) {
				if(count!=0) refs += ",";
				refs += (int) i;
				count++;
			}
			String tabs = "";
			/*for(int t = 0; t < level; t++) {
				tabs+="\t";
			}*/
			String children = "";
			for(TrieNode chld : this.chld) {
				children+= "\n";
				children+=chld.toXML(level+1);
			}
			return (tabs+"<T_"+this.str+ " ids='" + refs + "'>"+children+"\n" + tabs + "</T_"+this.str+">");
		}
	}
}
