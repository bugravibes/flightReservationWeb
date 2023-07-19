import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalTime;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class getCurrencyAPI {
	private static final long INTERVAL_HOURS = 3;

	public static void main(String[] args) {
		ScheduledExecutorService executorService = Executors.newSingleThreadScheduledExecutor();
		Runnable task = getCurrencyAPI::fetchCurrencyData;

		long initialDelay = calculateInitialDelay();

		ScheduledFuture<?> future = executorService.scheduleAtFixedRate(task, initialDelay, INTERVAL_HOURS,
				TimeUnit.HOURS);

		Runtime.getRuntime().addShutdownHook(new Thread(() -> {
			future.cancel(true);
			executorService.shutdown();
		}));
	}

	@SuppressWarnings("deprecation")
	private static void fetchCurrencyData() {
		String urlStr = "https://v6.exchangerate-api.com/v6/5140d8180a93d01a19667932/latest/USD";
		String dbUrl = "jdbc:mysql://localhost:3306/reservationsystem";
		String username = "root";
		String password = "mypass123";

		try (Connection connection = DriverManager.getConnection(dbUrl, username, password)) {
			URL url = new URL(urlStr);
			HttpURLConnection request = (HttpURLConnection) url.openConnection();
			request.connect();

			JsonParser jsonParser = new JsonParser();
			JsonElement root = jsonParser.parse(new InputStreamReader((InputStream) request.getContent()));
			JsonObject jsonObject = root.getAsJsonObject();

			if (jsonObject.get("result").getAsString().equals("success")) {
				JsonObject conversionRates = jsonObject.getAsJsonObject("conversion_rates");
				for (String currencyCode : conversionRates.keySet()) {
					Double rate = conversionRates.get(currencyCode).getAsDouble();
					insertCurrency(connection, currencyCode, rate);
				}
				System.out.println("Currency data inserted successfully.");
			} else {
				System.out.println("Failed to fetch currency data from the API.");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private static void insertCurrency(Connection connection, String currencyCode, Double rate) {
		String query = "INSERT INTO currency (currencyCode, rate) VALUES (?, ?)";
		try (PreparedStatement statement = connection.prepareStatement(query)) {
			statement.setString(1, currencyCode);
			statement.setDouble(2, rate);
			statement.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private static long calculateInitialDelay() {
		LocalTime now = LocalTime.now();
		long currentHours = now.getHour();
		long nextRunHour = (currentHours / INTERVAL_HOURS) * INTERVAL_HOURS + INTERVAL_HOURS;
		return nextRunHour - currentHours;
	}
}
