package irritate;

import org.apache.commons.beanutils.BeanUtils;

public class Test {

	public static void main(String[] args) {
		try {
			BeanUtils.createCache();
			throw new Exception();
		} catch (Exception e) {
			System.out.println("excep");
			return;
		} finally {
			System.out.println("finally");
		}
	}
}
