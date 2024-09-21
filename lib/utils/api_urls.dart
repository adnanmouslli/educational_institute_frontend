const String baseUrl="http://10.0.2.2/educational_institute/api";


const String studentUrl="$baseUrl/student";
const String markUrl="$baseUrl/marks";
const String alertUrl="$baseUrl/alerts";
const String loginUrl="$studentUrl/login.php";
const String registerUrl="$studentUrl/registration.php";
const String getMarksUrl="$markUrl/getAllMark.php";
const String getAlertsUrl="$alertUrl/getAllAlert.php";

const String getFilePdf="$baseUrl/information_bank/getFilePdf.php";

const String getDisclosure="$baseUrl/financial_disclosure/getDisclosure.php";
const String addDisclosure="$baseUrl/financial_disclosure/addDisclosure.php";



const Map<String,String> headerApi={"Content-Type": "application/json"};

