package com.mangalam.util;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // Aiven MySQL Database URL
    private static final String URL =
        "jdbc:mysql://mysql-363800ad-ombhavsar40-7913.c.aivencloud.com:25100/defaultdb?ssl-mode=REQUIRED";

    // Aiven Username
    private static final String USER = "avnadmin";

    // Aiven Password
   
    private static final String PASSWORD = System.getenv("DB_PASSWORD");
    static {

        try {

            // MySQL Driver Load
            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("MySQL Driver Loaded Successfully");

        } catch (ClassNotFoundException e) {

            System.out.println("MySQL Driver Not Found!");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {

        try {

            Connection con =
                    DriverManager.getConnection(URL, USER, PASSWORD);

            if (con != null) {

                System.out.println("Database Connected Successfully");

            } else {

                System.out.println("Database Connection Failed");
            }

            return con;

        } catch (SQLException e) {

            System.out.println("DB Connection Error:");
            e.printStackTrace();
        }

        return null;
    }

    public static void shutdown() {

        try {

            AbandonedConnectionCleanupThread.checkedShutdown();

        } catch (Exception e) {

            e.printStackTrace();
        }
    }
}