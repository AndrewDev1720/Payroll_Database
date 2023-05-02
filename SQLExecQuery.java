// Download and rename this file SQLExecQuery.java
// if it not properly named already.

// This file can be used to test connectivty to the university database.
// It returns the first 100 rows from the instructor table and requires
// the mssql-jdbc-11.2.0.jre11.jar and JDK 11. Our Virtual Machines should
// already be configured to have the appropriate information in the PATH, 
// CLASSPATH and JAVA_HOME environment variables. So, you should be 
// able to simply compile and run. See the next paragraph.

// To compile and run issue the following from a command line prompt
//  in Windows or usual Visual Studio Code
//    javac SQLExecQuery.java
//    java SQLExecQuery
import java.util.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSetMetaData;

public class SQLExecQuery {
    public static int choice = 0;
    public static Scanner sc;
    // Connect to your database.
    // Replace server name, username, and password with your credentials
    public static void main(String[] args) {


        String connectionUrl = 
        "jdbc:sqlserver://localhost;"
                + "database=payroll_system;"
                + "user=dtb;"
                + "password=123456;"
                + "encrypt=true;"
                + "trustServerCertificate=true;"
                + "loginTimeout=15;";

        ResultSet resultSet = null;

        try (Connection connection = DriverManager.getConnection(connectionUrl);
                Statement statement = connection.createStatement();) {

            // Create and execute a SELECT SQL statement.
            String selectSql = "SELECT * from employee";
            resultSet = statement.executeQuery(selectSql);
            // Print results from select statement
            while (resultSet.next()) {
                System.out.println(resultSet.getString(2) + " " + resultSet.getString(3));
            }

            // MENU

            
            int choice = -1;
            boolean exit = false;
            while(exit == false){
                sc = new Scanner(System.in);
                System.out.println("Menu option \n"); //printing on the screen to creat menu option for user to choose 
                System.out.println("1. Add employee \n");//printing on the screen to creat menu option for user to choose 
                System.out.println("2. View all employee \n");//printing on the screen to creat menu option for user to choose 
                System.out.println("3. Add job and salary to employee \n");//printing on the screen to creat menu option for user to choose 
                System.out.println("4. Generate payroll for one employee \n");//printing on the screen to creat menu option for user to choose 
                System.out.println("5. Generate payroll for all employees \n");//printing on the screen to creat menu option for user to choose 
                System.out.println("6. Exit the program \n\n");//printing on the screen to creat menu option for user to choose 
                System.out.print("Choose your option number: ");//printing on the screen to creat menu option for user to choose 
                choice = sc.nextInt();
                switch (choice) {
                    case 1 -> option1(connectionUrl);
                    case 2 -> option2(connectionUrl);
                    case 3 -> option3(connectionUrl);
                    case 4 -> option4(connectionUrl);
                    case 5 -> option5(connectionUrl);
                }
                System.out.println("\n");
                System.out.println("Press 'E' to exit the program, press 'M' to back to Menu option: "); // ask the user whether to return to menu or not
                String back = sc.next();
                if (back.equals("E")) // exit condition
                {
                    exit = true;
                }
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
            return;
        }
    }

    // employee
    public static void option1(String connectionUrl){
        System.out.println("Please enter your email: ");
        String email = sc.next();
        if(!validateEmail(email)){
            System.out.println("The input email is invalid!");
            return;
        } 
        email = "\'" + email + "\',";
        System.out.println("Please enter your first name: ");
        String firstName = sc.next();
        if(!isValidName(firstName)){
            System.out.println("The input first name is invalid!");
            return;
        }
        firstName = "\'" + firstName + "\',";
        System.out.println("Please enter your last name: ");
        String lastName = sc.next();
        if(!isValidName(lastName)){
            System.out.println("The input last name is invalid!");
            return;
        }
        lastName = "\'" + lastName + "\',";
        System.out.println("Please enter your date of birth: ");
        String dob = sc.next();
        if(!validateDate(dob)){
            System.out.println("The input date is invalid!");
            return;
        }
        dob = "\'" + dob + "\'";
        
        try (Connection connection = DriverManager.getConnection(connectionUrl);
                Statement statement = connection.createStatement();) {

            // Create and execute a SELECT SQL statement.
            String selectSql = "INSERT INTO employee (email, firstname, lastname, dateofbirth) VALUES " + "(" + email + firstName + lastName + dob +")";
            statement.execute(selectSql);
            System.out.println("Successfully insert the new employee!");
            // Print results from select statement
        }catch(Exception e){
            System.out.println("Email is already in use!");
            return;
        }
    }
    
     // employee
    public static void option2(String connectionUrl){
        String selectSql = "SELECT * from employee";
        printTable(connectionUrl, selectSql);
    }

    public static void option3(String connectionUrl){
        System.out.println("Please enter employee first name: ");
        String employeeFirstName = sc.next();
        if(!isValidName(employeeFirstName)) {
            System.out.println("The input first name is invalid!");
            return;
        }
        System.out.println("Please enter employee last name: ");
        String employeeLastName = sc.next(); 
        if(!isValidName(employeeLastName)) {
            System.out.println("The input last name is invalid!");
            return;
        }       
        String findEmployeeByName = "Select * from employee where firstname = " + formatInput(employeeFirstName) + "and lastname = " + formatInput(employeeLastName);
        printTable(connectionUrl, findEmployeeByName);
        System.out.print("Select the employee ID that you want to add the job: ");
        int employeeID = sc.nextInt();
        System.out.print("Please enter position name: ");
        String positionName = sc.next();
        if(!isValidName(positionName)){
            System.out.println("The input position name is invalid!");
            return;
        }    
        String findPositionByName = "Select * from position where position_name = " + formatInput(positionName);
        printTable(connectionUrl, findPositionByName);
        System.out.print("Select the position ID that you want to " + employeeFirstName + " "+ employeeLastName+ ": ");
        int positionID = sc.nextInt();

        System.out.print("Please specify the salary: ");
        int salary = sc.nextInt();
        try (Connection connection = DriverManager.getConnection(connectionUrl);
                Statement statement = connection.createStatement();) {
            // Create and execute a SELECT SQL statement.
            String selectSql = "INSERT INTO employee_position VALUES " + "(" + employeeID + ','+ positionID + "," + salary + ")";
            statement.execute(selectSql);
            System.out.println("Successfully add job to the specified employee!");
            // Print results from select statement
        }catch(Exception e){
            System.out.println("Input is not allowed!");
            return;
        }
    }

    private static String formatInput(String input){
        return "\'" + input + "\'";
    }

    private static void printTable(String connectionUrl, String selectSql){
        try (Connection connection = DriverManager.getConnection(connectionUrl);
            Statement statement = connection.createStatement();) {
            ResultSet resultSet = statement.executeQuery(selectSql);
            
            // Get the number of columns in the table
            ResultSetMetaData resultSetMetaData = resultSet.getMetaData();
            int columnCount = resultSetMetaData.getColumnCount();
            
            // Get the column names and maximum width of each column
            String[] columnNames = new String[columnCount];
            int[] columnWidths = new int[columnCount];
            for (int i = 1; i <= columnCount; i++) {
                columnNames[i - 1] = resultSetMetaData.getColumnName(i);
                columnWidths[i - 1] = columnNames[i - 1].length();
            }
            
            // Find the maximum width of each column
            while (resultSet.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    String value = resultSet.getString(i);
                    if (value != null) {
                        columnWidths[i - 1] = Math.max(columnWidths[i - 1], value.length());
                    }
                }
            }
            
            // Print the column names 
            for (int i = 0; i < columnCount; i++) {
                System.out.print(String.format("%-" + (columnWidths[i] + 2) + "s", columnNames[i]));
            }
            System.out.println();
            
            // Print a separator line
            for (int i = 0; i < columnCount; i++) {
                for (int j = 0; j < columnWidths[i] + 2; j++) {
                    System.out.print("-");
                }
            }
            System.out.println();
            
            // Create and execute the SELECT statement again to get a new ResultSet object
            resultSet = statement.executeQuery(selectSql);
            
            // Print the data
            while (resultSet.next()) {
                for (int i = 1; i <= columnCount; i++) {
                    System.out.print(String.format("%-" + (columnWidths[i - 1] + 2) + "s", resultSet.getString(i)));
                }
                System.out.println();
            }
        }catch(Exception e){
            System.out.print("Input is not allowed!");
            return;
        }
    }
    public static void option4(String connectionUrl){
        System.out.println("Please enter employee first name: ");
        String employeeFirstName = sc.next();
        if(!isValidName(employeeFirstName)) {
            System.out.println("The input first name is invalid!");
            return;
        }
        System.out.println("Please enter employee last name: ");
        String employeeLastName = sc.next();        
        if(!isValidName(employeeLastName)) {
            System.out.println("The input last name is invalid!");
            return;
        }
        String findEmployeeByName = "Select * from employee where firstname = " + formatInput(employeeFirstName) + "and lastname = " + formatInput(employeeLastName);
        printTable(connectionUrl, findEmployeeByName);
        System.out.print("Select the employee ID that you want to generate the payroll: ");
        int employeeID = sc.nextInt();
        System.out.print("Enter the start date of the payroll (yyyy-mm-dd): ");
        String startDate = formatInput(sc.next());
        if(!validateDate(startDate)){
            System.out.println("The input start date is invalid!");
            return;
        }
        System.out.print("Enter the end date of the payroll (yyyy-mm-dd): ");
        String endDate = formatInput(sc.next());
        if(!validateDate(endDate)){
            System.out.println("The input end date is invalid!");
            return;
        }
        try (Connection connection = DriverManager.getConnection(connectionUrl);
                Statement statement = connection.createStatement();) {
            // Create and execute a SELECT SQL statement.
            String selectSql = "EXEC generatePayRollForEmployee " + employeeID + ", " + startDate + "," + endDate;
            statement.execute(selectSql);
            System.out.println("Payroll for " + employeeFirstName + " " + employeeLastName +" " + "has successfully created");
            // Print results from select statement
        }catch(Exception e){
            System.out.println("Payroll not successfully created");
            return;
        }        
    }
    public static void option5(String connectionUrl){
        System.out.print("Enter the start date of the payroll (yyyy-mm-dd): ");
        String startDate = sc.next();
        if(!validateDate(startDate)){
            System.out.println("The input start date is invalid!");
            return;
        }

        startDate = formatInput(startDate);

        System.out.print("Enter the end date of the payroll (yyyy-mm-dd): ");
        String endDate = sc.next();
        if(!validateDate(endDate)){
            System.out.println("The input end date is invalid!");
            return;
        }

        endDate = formatInput(endDate);
        try (Connection connection = DriverManager.getConnection(connectionUrl);
                Statement statement = connection.createStatement();) {
            // Create and execute a SELECT SQL statement.
            String selectSql = "EXEC generatePayrollForAllEmployees2 " + startDate + "," + endDate;
            statement.execute(selectSql);
            System.out.println("Payroll for all of the employees have successfully been created.");
            // Print results from select statement
        }catch(Exception e){
            System.out.println(e);
            return;
        }


    }


    public static boolean validateEmail(String email) {
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";
        return email.matches(emailRegex);
    }

    public static boolean validateDate(String inputDate) {
        String dateRegex = "^\\d{4}-\\d{2}-\\d{2}$";
        return inputDate.matches(dateRegex);
    }

    public static boolean validateNumber(String inputNumber) {
        String numberRegex = "^\\d+$";
        return inputNumber.matches(numberRegex);
    }

    public static boolean isValidName(String firstName) {
        if (firstName == null || firstName.isEmpty()) {
            return false;
        }
        for (int i = 0; i < firstName.length(); i++) {
            char c = firstName.charAt(i);
            if (!Character.isLetter(c)) {
                return false;
            }
        }
        return true;
    }
}



