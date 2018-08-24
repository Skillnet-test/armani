package com.chelseasystems.cs.dataaccess;

import java.sql.SQLException;
import com.chelseasystems.cr.database.ParametricStatement;

/**
 * <p>Title: </p>
 *
 * <p>Description: </p>
 *
 * <p>Copyright: Copyright (c) 2006</p>
 *
 * <p>Company: </p>
 *
 * @author not attributable
 * @version 1.0
 */
public class CMSSQLException extends SQLException {
  private ParametricStatement stmt;
  private SQLException coreException;

  public CMSSQLException(SQLException ex, ParametricStatement stmt) {
    //super();
    coreException = ex;
    this.stmt = stmt;
  }

  public ParametricStatement getParametricStatement() {
    return stmt;
  }

  /**
   * Retrieves the SQLState for this <code>SQLException</code> object.
   *
   * @return the SQLState value
   */
  public String getSQLState() {
    if(coreException != null)
      return coreException.getSQLState();
    else
      return super.getSQLState();
  }

  /**
   * Retrieves the vendor-specific exception code
       * for this <code>SQLException</code> object.
   *
   * @return the vendor's error code
   */
  public int getErrorCode() {
    if(coreException != null)
      return coreException.getErrorCode();
    else
      return super.getErrorCode();
  }

  /**
   * Retrieves the exception chained to this
       * <code>SQLException</code> object.
   *
   * @return the next <code>SQLException</code> object in the chain;
       * <code>null</code> if there are none
   */
  public SQLException getNextException() {
    if(coreException != null)
      return coreException.getNextException();
    else
      return super.getNextException();
  }

  /**
   * Adds an <code>SQLException</code> object to the end of the chain.
   *
   * @param ex the new exception that will be added to the end of
       *            the <code>SQLException</code> chain
   */
  public synchronized void setNextException(SQLException ex) {
    if(coreException != null)
      coreException.setNextException(ex);
    else
      super.setNextException(ex);
  }



  /**
   * Returns the errort message string of this throwable object.
   *
   * @return  the error message string of this <code>Throwable</code>
   *          object if it was {@link #Throwable(String) created} with an
   *          error message string; or <code>null</code> if it was
   *          {@link #Throwable() created} with no error message.
   *
   */
  public String getMessage() {
    if(coreException != null)
      return coreException.getMessage();
    else
      return super.getMessage();
  }

  /**
   * Creates a localized description of this <code>Throwable</code>.
   * Subclasses may override this method in order to produce a
   * locale-specific message.  For subclasses that do not override this
   * method, the default implementation returns the same result as
   * <code>getMessage()</code>.
   *
   * @since   JDK1.1
   */
  public String getLocalizedMessage() {
    if(coreException != null)
      return coreException.getLocalizedMessage();
    else
      return super.getLocalizedMessage();
  }


  /**
   * Returns a short description of this throwable object.
   * If this <code>Throwable</code> object was
   * {@link #Throwable(String) created} with an error message string,
   * then the result is the concatenation of three strings:
   * <ul>
   * <li>The name of the actual class of this object
   * <li>": " (a colon and a space)
   * <li>The result of the {@link #getMessage} method for this object
   * </ul>
   * If this <code>Throwable</code> object was {@link #Throwable() created}
   * with no error message string, then the name of the actual class of
   * this object is returned.
   *
   * @return  a string representation of this <code>Throwable</code>.
   */
  public String toString() {
    if(coreException != null)
      return coreException.toString();
    else
      return super.toString();
  }

  /**
   * Prints this <code>Throwable</code> and its backtrace to the
   * standard error stream. This method prints a stack trace for this
   * <code>Throwable</code> object on the error output stream that is
   * the value of the field <code>System.err</code>. The first line of
   * output contains the result of the {@link #toString()} method for
   * this object. Remaining lines represent data previously recorded by
   * the method {@link #fillInStackTrace()}. The format of this
   * information depends on the implementation, but the following
   * example may be regarded as typical:
   * <blockquote><pre>
   * java.lang.NullPointerException
   *         at MyClass.mash(MyClass.java:9)
   *         at MyClass.crunch(MyClass.java:6)
   *         at MyClass.main(MyClass.java:3)
   * </pre></blockquote>
   * This example was produced by running the program:
   * <blockquote><pre>
   *
   * class MyClass {
   *
   *     public static void main(String[] argv) {
   *         crunch(null);
   *     }
   *     static void crunch(int[] a) {
   *         mash(a);
   *     }
   *
   *     static void mash(int[] b) {
   *         System.out.println(b[0]);
   *     }
   * }
   * </pre></blockquote>
   *
   * @see     java.lang.System#err
   */
  public void printStackTrace() {
    if(coreException != null)
      coreException.printStackTrace();
    else
      super.printStackTrace();
  }

  /**
   * Prints this <code>Throwable</code> and its backtrace to the
   * specified print stream.
   */
  public void printStackTrace(java.io.PrintStream s) {
    if(coreException != null)
      coreException.printStackTrace(s);
    else
      super.printStackTrace(s);
  }

  /**
   * Prints this <code>Throwable</code> and its backtrace to the specified
   * print writer.
   *
   * @since   JDK1.1
   */
  public void printStackTrace(java.io.PrintWriter s) {
    if(coreException != null)
      coreException.printStackTrace(s);
    else
      super.printStackTrace(s);
  }

  /**
   * Fills in the execution stack trace. This method records within this
   * <code>Throwable</code> object information about the current state of
   * the stack frames for the current thread. This method is useful when
   * an application is re-throwing an error or exception. For example:
   * <p><blockquote><pre>
   *     try {
   *         a = b / c;
   *     } catch(ArithmeticThrowable e) {
   *         a = Number.MAX_VALUE;
   *         throw e.fillInStackTrace();
   *     }
   * </pre></blockquote>
   *
   * @return  this <code>Throwable</code> object.
   * @see     java.lang.Throwable#printStackTrace()
   */
  public Throwable fillInStackTrace() {
    if(coreException != null)
      return coreException.fillInStackTrace();
    else
      return super.fillInStackTrace();
  }

}
