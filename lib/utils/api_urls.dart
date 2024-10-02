const String baseUrl="http://10.0.2.2/educational_institute/api";
// const String baseUrl="http://192.168.72.128:9000/educational_institute/api";


const String serverAi ="http://10.0.2.2:5000/predict";


const String studentUrl="$baseUrl/student";
const String markUrl="$baseUrl/marks";
const String alertUrl="$baseUrl/alerts";

const String loginUrl="$baseUrl/student/login.php";
const String loginSupervisorUrl="$baseUrl/supervisors/login.php";

const String registerUrl="$studentUrl/registration.php";
const String getMarksUrl="$markUrl/getAllMark.php";
const String getAlertsUrl="$alertUrl/getAllAlert.php";

const String getFilePdf="$baseUrl/information_bank/getFilePdf.php";

const String getDisclosure="$baseUrl/financial_disclosure/getDisclosure.php";
const String addDisclosure="$baseUrl/financial_disclosure/addDisclosure.php";

const String addAlert="$baseUrl/alerts/addAlert.php";

const String addSection="$baseUrl/section/addSection.php";

const String getStatus="$baseUrl/marks/getStudentStatus.php";


const String getAllStudentT="$baseUrl/marks/getAllStudentT.php";
const String getAllStudentB="$baseUrl/marks/getAllStudentB.php";
const String getAllSubjectT="$baseUrl/marks/getAllSubjectT.php";
const String getAllSubjectB="$baseUrl/marks/getAllSubjectB.php";
const String addMarkStudent="$baseUrl/marks/addMark.php";








const Map<String,String> headerApi={"Content-Type": "application/json"};