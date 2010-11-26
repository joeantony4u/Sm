package irritate;

public class Test {

	public class inner {

	}

	public interface innerI {

	}

	public static void main(String[] args) {
		for (Class<?> c : Test.class.getClasses())
			System.out.println(c.getName());
	}
}
