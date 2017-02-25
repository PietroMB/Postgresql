        try{
            String url="jdbc:postgresql://127.0.0.1/postgres";
            String userid="postgres";
            String password="postgres";
            con=DriverManager.getConnection(url,userid,password);
            Statement stmt = con.createStatement();
            //stmt.executeUpdate("create schema prova");
            ResultSet rs = stmt.executeQuery("select * from biblioteca.ha_letto");
            PreparedStatement ps = con.prepareStatement("insert into biblioteca.copia values (?,?)");
            while(rs.next()){
                String isbn=rs.getString("isbn");
                String socio=rs.getString("socio");
                System.out.println(isbn+" "+socio);
                ps.setString(1, isbn);
                ps.setString(2, socio);
                ps.execute();
            }
            
            rs.close();
            ps.close();
            stmt.close();
            con.close();
        }catch(Exception e){
            e.printStackTrace();
        }
