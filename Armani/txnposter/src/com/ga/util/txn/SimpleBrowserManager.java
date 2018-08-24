package com.ga.util.txn;

import com.chelseasystems.cr.appmgr.RepositoryManager;
import com.chelseasystems.cr.appmgr.IBrowserManager;
import com.chelseasystems.cr.swing.IMainFrame;
import java.rmi.Remote;
import java.rmi.server.RemoteStub;
import com.chelseasystems.cr.node.ContainerVitalsHolder;
import com.chelseasystems.cr.node.ContainerVitals;
import com.chelseasystems.cr.node.ComponentVitals;
import com.chelseasystems.cr.multicast.IProcessSocketEvent;

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
public class SimpleBrowserManager extends RepositoryManager implements IBrowserManager {
  public SimpleBrowserManager() {
    super();
  }

  public static void main(String[] args) {
    SimpleBrowserManager simplebrowsermanager = new SimpleBrowserManager();
  }

  public void goHome() {
  }

  public IMainFrame getMainFrame() {
    return null;
  }

  public int getPendingTxnCount() {
    return 0;
  }

  public void setPendingTxnCount(int _int) {
  }

  public int getBrokenTxnCount() {
    return 0;
  }

  public void setBrokenTxnCount(int _int) {
  }

  public String[] getPeerAddresses() {
    return null;
  }

  public void setOnLine(boolean _boolean) {
  }

  public boolean isOnLine() {
    return true;
  }

  public Remote[] getPeerStubs(String string) {
    return null;
  }

  public void removeRemotePeerStub(String string, Remote remote) {
  }

  public Remote getLocalStub(String string) {
    return null;
  }

  public String[] getLocalStubKeys() {
    return null;
  }

  public void addLocalPeerStub(String string, RemoteStub remoteStub) {
  }

  public void restartTerminal() throws Exception {
  }

  public void addPerformance(String string, long _long) {
  }

  public ContainerVitalsHolder getContainerVitalsHolder() {
    return null;
  }

  public void saveContainerVitalsHolder(ContainerVitalsHolder containerVitalsHolder) {
  }

  public ContainerVitals getContainerVitals() {
    return null;
  }

  public ComponentVitals getComponentVitals() {
    return null;
  }

  public void incConnection() {
  }

  public void decConnection() {
  }

  public void registerSocketEventProcessor(String string, IProcessSocketEvent iProcessSocketEvent) {
  }

  public void unregisterSocketEventProcessor(String string) {
  }
}
