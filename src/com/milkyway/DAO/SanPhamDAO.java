/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.milkyway.DAO;

import com.milkyway.Model.SanPham;
import java.util.List;

/**
 *
 * @author hoang
 */
public class SanPhamDAO extends MilkyWayDAO<SanPham, String> {
    
    final String Insert_SQL = "";
    final String Update_SQL = "";
    final String Delete_SQL = "";
    final String SelectAll_SQL = "";
    final String SelectByID_SQL = "";

    @Override
    public void insert(SanPham entity) {

    }

    @Override
    public void update(SanPham entity) {

    }

    @Override
    public void delete(String id) {

    }

    @Override
    public SanPham selectById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<SanPham> selectAll() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    protected List<SanPham> selectBySql(String sql, Object... args) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
