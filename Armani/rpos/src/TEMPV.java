import com.chelseasystems.cr.payment.Redeemable;
import com.chelseasystems.cs.payment.CMSDueBill;
import com.chelseasystems.cs.payment.CMSStoreValueCard;


public class TEMPV {
public static void main(String[] args) {
	CMSStoreValueCard cs=null;
	CMSDueBill cd=null;
	
	if(cs instanceof Redeemable){
		System.out.println(" cmsstorevaluecard");
	}
	if(cd instanceof Redeemable){
		System.out.println("cmsduebill ");
	}
}
}
