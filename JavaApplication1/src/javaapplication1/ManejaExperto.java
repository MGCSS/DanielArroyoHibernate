/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javaapplication1;

import modelos.Experto;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Horizon
 */
public class ManejaExperto {
    private Session sesion;
    private Transaction tx;

    public ManejaExperto() {
    }

    public void iniciaOperacion() throws HibernateException {
        //Comenzando Hibernate
        sesion = HibernateUtil.getSessionFactory().openSession(); //inicia sesion hibernate
        tx = sesion.beginTransaction(); // comienza la transaccion
    }

    public void finalizaOperacion() throws HibernateException {
        //Finalizando Hibernate
        tx.commit();
        sesion.close();
    }

    public void manejaExcepcion(HibernateException he) throws HibernateException {
        tx.rollback();
        System.out.println("error en la capa de acceso a datos " + he.getMessage());
        System.exit(0);
    }


    public boolean guardaExperto(Experto experto) {
        boolean ret=false;
        try {
            iniciaOperacion();
            sesion.save(experto);
            ret=true;
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } finally {
            finalizaOperacion();
        }
        return ret;
    }
    
    public void eliminaExperto(Experto experto) throws HibernateException {
        try {
            iniciaOperacion();
            sesion.delete(experto);
            System.out.println("Experto eliminado correctamente");
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } finally {
            finalizaOperacion();
        }
    }
    
    public void actualizaExperto(Experto experto) throws HibernateException {
        try {
            iniciaOperacion();
            sesion.update(experto);
            System.out.println("Experto actualizado correctamente");
        } catch (HibernateException he) {
            manejaExcepcion(he);
            throw he;
        } finally {
            finalizaOperacion();
        }        
    }
    
    public Experto obtenExperto(String idExperto) throws HibernateException {
        Experto experto= null;
        String hql= "from Experto e where e.codexperto = :idExperto";
        List <Experto> listaExperto;
        
        this.iniciaOperacion();
        
        Query query= sesion.createQuery(hql);
        query.setParameter("idExperto", idExperto);
        listaExperto= query.list();
        
        if (listaExperto.isEmpty() != true) {
            experto = listaExperto.get(0);
        }
        
        this.finalizaOperacion();
        
        return experto;
        
    }
    
    
    public List obtenExpertos() throws HibernateException {
        Experto experto= null;
        String hql= "from Experto e";
        List <Experto> listaExperto;
        
        this.iniciaOperacion();
        
        Query query= sesion.createQuery(hql);
        listaExperto= query.list();
        
        if (listaExperto.isEmpty() != true) {
            experto = listaExperto.get(0);
        }
        
        this.finalizaOperacion();
        
        return listaExperto;
        
    }
    
    
    
    
    
    
    
    public void obtenNombresyEspecialidad() throws HibernateException {
        String hql= "select nombre, especialidad from Experto";
        List <Object []> listaExperto;
        
        this.iniciaOperacion();
        
        Query query= sesion.createQuery(hql);
        listaExperto= query.list();
        
        if (listaExperto.isEmpty() != true) {
            System.out.println();
            System.out.println("Listado de Experto con la especialidad.");
            for (int i= 0; i < listaExperto.size(); i++) {
                System.out.println("Experto: " + listaExperto.get(i)[0] + 
                                    ". Especialidad: " + listaExperto.get(i)[1]);
               
            }
        }
        else {
            System.out.println("No existe ningun experto.");
        }
        
        System.out.println("Pulse Intro para continuar.");
        try {
            System.in.read();
        } catch (IOException ex) {
            Logger.getLogger(ManejaExperto.class.getName()).log(Level.SEVERE, null, ex);
        }        
        this.finalizaOperacion();
        
    }    
    
    public void listaConParametro(String keyword) throws HibernateException {
        String hql= "from Experto e where e.especialidad = :keyword";
        List <Experto> listaExperto;
        
        this.iniciaOperacion();
        
        Query query= sesion.createQuery(hql);
        query.setParameter("keyword", keyword);
        listaExperto= query.list();
        
        if (listaExperto.isEmpty() != true) {
            System.out.println();
            System.out.println("Listado de Experto con la especialidad: " + keyword);
            for (Experto aExperto : listaExperto) {
                System.out.println(aExperto.getNombre());
            }
        }
        else {
            System.out.println("No existe ningun experto con la especialidad: " + keyword);
        }
        
        System.out.println("Pulse Intro para continuar.");
        try {
            System.in.read();
        } catch (IOException ex) {
            Logger.getLogger(ManejaExperto.class.getName()).log(Level.SEVERE, null, ex);
        }        
        this.finalizaOperacion();        
    }
    
    /*public void obtenCasos() throws HibernateException {
        
        
        String hql= "select distinct e.nombre, c.nombre from CasoPolicial as c, Experto as e";
        List <Object []> listaCasos;
        
        this.iniciaOperacion();
        
        Query query= sesion.createQuery(hql);
        listaCasos= query.list();
        
        if (listaCasos.isEmpty() != true) {
            System.out.println();
            System.out.println("Listado de Experto y Casos participado.");
            for (int i= 0; i < listaCasos.size();i++) {
                System.out.println("Experto: " + listaCasos.get(i)[0] + ". Casos: " + listaCasos.get(i)[1]);
            }
        }
        else {
            System.out.println("No existe ningun caso.: ");
        }
        
        System.out.println("Pulse Intro para continuar.");
        try {
            System.in.read();
        } catch (IOException ex) {
            Logger.getLogger(ManejaExperto.class.getName()).log(Level.SEVERE, null, ex);
        }        
        this.finalizaOperacion();        
    }*/
    
    public List <Object []> obtenCasos() throws HibernateException {
        
        String hql= "select distinct e.nombre, c.nombre from CasoPolicial as c, Experto as e";
        List <Object []> listaCasos;
        
        this.iniciaOperacion();
        
        Query query= sesion.createQuery(hql);
        listaCasos= query.list();
        
        
           
        this.finalizaOperacion();        
        return listaCasos;
    }
}
