import os
import csv

import csv

def read_csv_file():
    file_path = 'data.csv'

    task_list = []

    with open(file_path) as csvfile:
        csv_reader = csv.reader(csvfile, delimiter=',')
        
        # Pominięcie pierwszej linii (nagłówek)
        next(csv_reader, None)

        for row in csv_reader:
            task_list.append(row)

    return task_list