# The Databricks runtime websites 
# list the packages that are installed
# but if building a custom DCS container it is not possible to 
# extract these as a requirements.txt or conda env

# This parser reads the runtime website and dumps out a yaml
# This requires the following python packages
## lxml
## html5lib

# in order for pandas to be able to parse html properly

# The output is not fully ready. 
# As There is no automated way to determine which libs should be conda installed
# versus pip installed
# that will still require a bit of manual testing

import requests
from bs4 import BeautifulSoup as soup
import pandas as pd
import yaml

def extract_cpu_gpu_section(url: str='https://docs.databricks.com/release-notes/runtime/10.3ml.html',
                            section: str='python-libraries-on-gpu-clusters'):
    """
    Args:
        url: the databricks runtime url to parse
        section: this can be either python-libraries-on-gpu-clusters
                    or python-libraries-on-cpu-clusters

    Returns:
        section: html section for pandas

    """

    webpage = requests.get(url)
    soupy_object = soup(webpage.text, 'html.parser')
    section = section = soupy_object.find("div", {"id": section})

    return section


if __name__ == '__main__':

    section = extract_cpu_gpu_section()

    data_table = pd.read_html(str(section))[0]

    assert data_table.shape[1] == 6, """the table doesn't have 6 columns?
            We expect the table to have columns:
            Library | Version | Library.1 | Version.1 | Library.2 | Version.2 
        """

    # Databricks table is three columns by default
    col_1 = data_table[['Library', 'Version']]
    col_2 = data_table[['Library.1', 'Version.1']].rename(columns={'Library.1': 'Library', 'Version.1': 'Version'})
    col_3 = data_table[['Library.2', 'Version.2']].rename(columns={'Library.2': 'Library', 'Version.2': 'Version'})

    net_packages = pd.concat([col_1, col_2, col_3]).dropna()
    
    net_packages['conda_string'] = net_packages['Library'] + '=' + net_packages['Version']

    ## Output
    with open(r'requirements.yaml', 'w') as file:
        documents = yaml.dump(net_packages['conda_string'].tolist(), file, explicit_start=True, default_flow_style=False)