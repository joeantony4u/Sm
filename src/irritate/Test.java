package irritate;

public class Test {

	public static void main(String[] args) {
		try {
			System.out.println(System.getProperty("line.separator"));
		} catch (Exception e) {
			System.out.println("excep");
			return;
		} finally {
			System.out.println("finally");
		}
	}
}
