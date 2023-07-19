import java.util.Random;

public class generateRandomPNR {
	public class java {

	}

	private static final String ALPHA_NUMERIC_STRING = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
	private static final int PNR_LENGTH = 6;

	public static String generateRandomPNR() {
		StringBuilder sb = new StringBuilder(PNR_LENGTH);
		Random random = new Random();

		for (int i = 0; i < PNR_LENGTH; i++) {
			int index = random.nextInt(ALPHA_NUMERIC_STRING.length());
			char randomChar = ALPHA_NUMERIC_STRING.charAt(index);
			sb.append(randomChar);
		}

		return sb.toString();

	}

}
