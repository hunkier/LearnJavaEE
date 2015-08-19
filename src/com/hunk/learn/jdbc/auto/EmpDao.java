package com.hunk.learn.jdbc.auto;

import com.hunk.learn.jdbc.DbUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 * Created by hunk on 2015/8/11.
 */
public class EmpDao {
    private Connection con;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public void save(Employee emp){
        // 保存部门
        String sql_dept = "insert into dept(deptName) values(?)";
        // 保存员工
        String sql_emp = "insert into employee(empName,deptId) values(?,?)";
        // 部门id
        int deptId = 0 ;

        try {
            // 连接
            con = DbUtil.getConnection();

            /****  保存部门，获取自增长  ****/
            // 一、需要指定返回自增长标记
            pstmt = con.prepareStatement(sql_dept, Statement.RETURN_GENERATED_KEYS);
            // 设置参数
            pstmt.setString(1,emp.getDept().getDeptName());
            // 执行
            pstmt.executeUpdate();

            // 二、获取上面保存的部门自增长的主键
            rs = pstmt.getGeneratedKeys();
            // 得到返回自增长字段
            if (rs.next()){
                deptId = rs.getInt(1);
            }

            /*****  保存员工  ****/
            pstmt = con.prepareCall(sql_emp);
            // 设置参数
            pstmt.setString(1,emp.getEmpName());
            pstmt.setInt(2,deptId);
            pstmt.executeUpdate();



        } catch (Exception e) {
            e.printStackTrace();
            throw  new RuntimeException(e);
        } finally {
            DbUtil.close(con,pstmt,rs);
        }

    }
}
