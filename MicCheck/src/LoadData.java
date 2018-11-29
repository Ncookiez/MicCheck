import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Scanner;

public class LoadData {
	
	// Main method:
	public static void main(String[] argv) throws Exception {
		loadData();
	}
	
	// Method to load data into the database:
	public static void loadData() throws Exception {
		
		// Creating connection to database:
		String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=<USERNAME>";
		String uid = "<USERNAME>";
		String pw = "<ID>";
		System.out.println("Connecting to database.");
		Connection con = DriverManager.getConnection(url, uid, pw);
		
		String fileName = "data/pageinfo_sql.ddl";
		
	    try {
	    	
	    	// Setup:
	        Statement stmt = con.createStatement();
	        Scanner scanner = new Scanner(new File(fileName));
	        scanner.useDelimiter(";");
	        
	        // Adding data to database:
	        while(scanner.hasNext()) {
	            String command = scanner.next();
	            if(command.trim().equals("")) { continue; }
	            System.out.println(command);
	            try {
	            	stmt.execute(command);
	            } catch(Exception e) {
	            	System.out.println(e);
	            }
	        }
	        scanner.close();
	    } catch(Exception e) {
	        System.out.println(e);
	    }
	}
}