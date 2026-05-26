package com.mangalam.controller;

import java.io.File;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import com.mangalam.dao.ProductDAO;

@WebServlet("/ProductServlet")

@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,
    maxFileSize = 1024 * 1024 * 5,
    maxRequestSize = 1024 * 1024 * 10
)

public class ProductServlet extends HttpServlet {

    // =========================
    // 🔴 DELETE PRODUCT
    // =========================

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        ProductDAO dao = new ProductDAO();

        // =========================
        // 🔥 DELETE
        // =========================

        if ("delete".equals(action)) {

            try {

                int id = Integer.parseInt(
                        request.getParameter("id")
                );

                boolean status =
                        dao.deleteProduct(id);

                if (status) {

                    response.sendRedirect(
                            "admdashpromngt.jsp?msg=deleted"
                    );

                } else {

                    response.sendRedirect(
                            "admdashpromngt.jsp?msg=error"
                    );
                }

            } catch (Exception e) {

                e.printStackTrace();

                response.sendRedirect(
                        "admdashpromngt.jsp?msg=error"
                );
            }
        }
    }

    // =========================
    // 🟢 ADD + UPDATE PRODUCT
    // =========================

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action =
                request.getParameter("action");

        ProductDAO dao =
                new ProductDAO();

        // =========================
        // 🔥 ADD PRODUCT
        // =========================

        if ("add".equals(action)) {

            try {

                // 🔹 PRODUCT DETAILS

                String name =
                        request.getParameter("pName");

                String cat =
                        request.getParameter("pCat");

                double price =
                        Double.parseDouble(
                                request.getParameter("pPrice")
                        );

                int stock =
                        Integer.parseInt(
                                request.getParameter("pStock")
                        );

                String desc =
                        request.getParameter("pDesc");

                int packSizes =
                        Integer.parseInt(
                                request.getParameter("packSizes")
                        );

                // =========================
                // 🔥 IMAGE
                // =========================

                Part part =
                        request.getPart("pImage");

                String originalFileName =
                        part.getSubmittedFileName();

                String fileName =
                        System.currentTimeMillis()
                        + "_"
                        + originalFileName;

                String uploadPath =
                        getServletContext()
                        .getRealPath("")
                        + "images/products/";

                File uploadDir =
                        new File(uploadPath);

                if (!uploadDir.exists()) {

                    uploadDir.mkdirs();
                }

                // SAVE IMAGE

                part.write(
                        uploadPath
                        + File.separator
                        + fileName
                );

                // =========================
                // 🔥 SAVE PRODUCT
                // =========================

                boolean status =
                        dao.addProduct(
                                name,
                                cat,
                                price,
                                stock,
                                desc,
                                fileName,
                                packSizes
                        );

                // =========================
                // 🔥 RESPONSE
                // =========================

                if (status) {

                    response.sendRedirect(
                            "admdashpromngt.jsp?msg=success"
                    );

                } else {

                    response.sendRedirect(
                            "admdashpromngt.jsp?msg=error"
                    );
                }

            } catch (Exception e) {

                e.printStackTrace();

                response.sendRedirect(
                        "admdashpromngt.jsp?msg=error"
                );
            }
        }

        // =========================
        // 🔵 UPDATE PRODUCT
        // =========================

        else if ("update".equals(action)) {

            try {

                int id =
                        Integer.parseInt(
                                request.getParameter("pId")
                        );

                String name =
                        request.getParameter("pName");

                String cat =
                        request.getParameter("pCat");

                double price =
                        Double.parseDouble(
                                request.getParameter("pPrice")
                        );

                int stock =
                        Integer.parseInt(
                                request.getParameter("pStock")
                        );

                int pack =
                        Integer.parseInt(
                                request.getParameter("packSizes")
                        );

                String desc =
                        request.getParameter("pDesc");

                // =========================
                // 🔥 UPDATE PRODUCT
                // =========================

                boolean status =
                        dao.updateProduct(
                                id,
                                name,
                                cat,
                                price,
                                stock,
                                pack,
                                desc
                        );

                // =========================
                // 🔥 RESPONSE
                // =========================

                if (status) {

                    response.sendRedirect(
                            "admdashpromngt.jsp?msg=updated"
                    );

                } else {

                    response.sendRedirect(
                            "admdashpromngt.jsp?msg=error"
                    );
                }

            } catch (Exception e) {

                e.printStackTrace();

                response.sendRedirect(
                        "admdashpromngt.jsp?msg=error"
                );
            }
        }
    }
}