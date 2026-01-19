from datetime import datetime
from email.message import EmailMessage  # Build email with attachment
import ssl  # Secure connection to gmail SMTP
import smtplib  # Send email via SMTP
import re   # Regex parsing of transcript
import os

email_sender = 'mab88889@gmail.com'
email_password = 'skht smyc xmmm mhsa'
email_receiver = 'mbhavsar2997@gmail.com'
now = datetime.now()

# Format the date and time
formatted_date_time = now.strftime("Date: %Y-%m-%d \t Time:%H:%M:%S")

subject = 'Regression Result:\t' + formatted_date_time
body = """

Hello,

The regression result is attached in report.txt file.


Regards,
Manank Bhavsar

"""

TB = "../TOP/router_top.sv"
TBModule = "router_top"
PKG = "../TEST/router_pkg.sv"
RTL = "../RTL/*"

# Testcase List
TC_LIST = [
    "router_header_addr_00_test",
    "router_header_addr_01_test",
    "router_header_addr_10_test",
    "router_header_addr_11_test",
    "router_header_len_0_test",
    "router_min_header_len_test",
    "router_mid_header_len_test",
    "router_max_header_len_test",
    "router_min_payload_data_test",
    "router_mid_payload_data_test",
    "router_max_payload_data_test",
    "router_mid_reset_test",
    "router_soft_reset_0_test",
    "router_soft_reset_1_test",
    "router_soft_reset_2_test"
]

report_file = open("report.txt", 'w')

file_path = "report.txt"  # Replace with the actual file path
file_name = "report.txt"  # Friendly name for the file in the email

single_test = int(input("\nDo you want to run a single test multiple times?\n 1 - YES :::: 0 - NO\n"))
delete_prev_logs = int(input("\nDo you want to delete previous coverage files?\n 1 - YES :::: 0 - NO\n"))


if delete_prev_logs == 1:
    os.system('del *.ucdb')

os.system('vlib work')
os.system(f'vlog -coveropt 3 +acc +cover {RTL} {PKG} {TB} +incdir+../RTL +incdir+../ENV +incdir+../TEST')

def fetch_and_write_into_report(testname):
    seed_number = None
    uvm_error_line = None

    with open("transcript", 'r') as file:
        for line in file:
            if 'Sv_Seed' in line:
                match = re.search(r'#\s*Sv_Seed\s*=\s*(\d+)', line)     # Capturing the pattern = {# Sv_Seed = 2946204306} from transcript file
                if match:
                    seed_number = match.group(1)     # group(1) returns the measured value of (\d+)
            if 'UVM_ERROR' in line:
                uvm_error_line = line.strip()

    with open("report.txt", 'a') as report_file:
        if seed_number or uvm_error_line:
            report_file.write(f"TESTNAME: {testname} SEED: {seed_number or 'N/A'} {uvm_error_line or ''}\n\n")


if single_test == 0:
    repeat_test_counts = int(input("\nHow many times do you want to run each test in regression?"))
    cov_dump = int(input("\nDo you want to dump the coverage?\n 1 - YES :::: 0 - NO\n"))
    for i in range(repeat_test_counts):
        for test in TC_LIST:
            if cov_dump:
                os.system(
                    f'vsim -coverage -vopt {TBModule} -sv_seed random -c -do "coverage save -onexit {test}_{i}.ucdb; run -all; exit" '
                    f'+UVM_TESTNAME={test} +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION'
                )
                fetch_and_write_into_report(test)
            else:
                os.system(
                    f'vsim -vopt {TBModule} -sv_seed random -c -do "run -all; exit" '
                    f'+UVM_TESTNAME={test} +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION'
                )
                fetch_and_write_into_report(test)

        if cov_dump:
            os.system(f'vcover merge mergecov_{i}.ucdb ' + ' '.join([f"{test}_{i}.ucdb" for test in TC_LIST]))

            if i == 0:
                os.system('vcover merge mergecov.ucdb mergecov_0.ucdb')
            else:
                os.system(f'vcover merge mergecov.ucdb mergecov.ucdb mergecov_{i}.ucdb')

            os.system('vcover report -details -html mergecov.ucdb')

if single_test == 1:
    test_name = input("\nEnter the test name: ")
    repeat_test_counts = int(input("\nHow many times do you want to run the test in regression?"))

    for i in range(repeat_test_counts):
        os.system(
            f'vsim -coverage -vopt {TBModule} -sv_seed random -c -do "coverage save -onexit {test_name}_{i}.ucdb; run -all; exit" '
            f'+UVM_TESTNAME={test_name} +UVM_VERBOSITY=UVM_DEBUG +uvm_set_action=*,_ALL_,UVM_INFO,UVM_NO_ACTION'
        )
        fetch_and_write_into_report(test_name)

        if i == 0:
            os.system(f'vcover merge mergecov.ucdb {test_name}_{i}.ucdb')
        else:
            os.system(f'vcover merge mergecov.ucdb mergecov.ucdb {test_name}_{i}.ucdb')

    os.system('vcover report -details -html mergecov.ucdb')

em = EmailMessage()
em ['From'] = email_sender
em ['To'] = email_receiver
em ['Subject'] = subject
em.set_content(body)

try:
    with open(file_path, 'rb') as file:
        file_data = file.read()
        file_type = 'application/txt'  # MIME type
        em.add_attachment(file_data, maintype='application', subtype='txt', filename=file_name)
except FileNotFoundError:
    print(f"Error: The file '{file_path}' was not found.")

# Setup the secure connection and send the email
context = ssl.create_default_context()
with smtplib.SMTP('smtp.gmail.com', 587) as smtp:
    smtp.starttls()
    smtp.login(email_sender, email_password)
    smtp.sendmail(email_sender, email_receiver, em.as_string())
    
print('Email Sent!')