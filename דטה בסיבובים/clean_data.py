import pandas as pd


def clean_data(input_file, output_file):
    # Read the Excel file
    df = pd.read_excel(input_file)

    # Filter rows based on the criteria
    filtered_df = df[(df['norm_pos_x'] >= -100) & (df['norm_pos_y'] <= 600)]

    # Save the cleaned data to a new Excel file
    filtered_df.to_excel(output_file, index=False)

    print("Data cleaning complete. Cleaned data saved to:", output_file)


# Path to the input Excel file
input_file = r"C:\Users\shach\Documents\Shachar-s_Thesis2\דטה בסיבובים\PD02-MB345_OFF.xlsx"
# Path to the output Excel file
output_file = r"C:\Users\shach\Documents\Shachar-s_Thesis2\דטה בסיבובים\PD02-MB345_OFF_cleaned.xlsx"
# Call the function
clean_data(input_file, output_file)