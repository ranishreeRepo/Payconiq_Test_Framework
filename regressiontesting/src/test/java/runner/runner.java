package runner;
import org.testng.annotations.DataProvider;
import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;

@CucumberOptions(
		features= "F:\\Git Repo\\Payconiq_Test_Framework\\regressiontesting\\src\\test\\resources\\features\\Assignment_Flow", 
		glue={"stepDef"},
		tags = ("@UpdateBooking")
		)

public class runner extends AbstractTestNGCucumberTests{
	@Override
	@DataProvider(parallel = true)
	public Object[][] scenarios() {
		return super.scenarios();
	}
}            