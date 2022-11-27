package runner;
import org.testng.annotations.DataProvider;
import io.cucumber.testng.AbstractTestNGCucumberTests;
import io.cucumber.testng.CucumberOptions;

@CucumberOptions(features= "feature", tags= "",glue={"com.payconic.project.RegressionTesting_StepDefinition"})

public class runner extends AbstractTestNGCucumberTests{

	@Override

	@DataProvider(parallel = true)

	public Object[][] scenarios() {

		return super.scenarios();

	}



}            