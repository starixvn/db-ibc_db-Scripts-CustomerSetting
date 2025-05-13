# d:\GIT\db-Scripts-CustomerSetting\Scripts\Other\NewProduct\3rdProduct_Template\.bat\replace_excel.py
import sys
import os
import xlrd  # For reading .xls files
import xlwt  # For writing .xls files
from openpyxl import load_workbook
import shutil

def process_xls_file(file_path, replacements):
    """Process old .xls format files using xlrd and xlwt"""
    try:
        # Read the original workbook
        rb = xlrd.open_workbook(file_path)
        wb = xlwt.Workbook()

        # Process each sheet
        for sheet_idx in range(rb.nsheets):
            rs = rb.sheet_by_index(sheet_idx)
            ws = wb.add_sheet(rs.name)

            # Copy and process each cell
            for row_idx in range(rs.nrows):
                for col_idx in range(rs.ncols):
                    cell_value = rs.cell_value(row_idx, col_idx)
                    
                    # Only process string values
                    if isinstance(cell_value, str):
                        modified = False
                        for find, replace in replacements.items():
                            if find in cell_value:
                                cell_value = cell_value.replace(find, replace)
                                modified = True
                    
                    # Write the cell value (modified or original)
                    ws.write(row_idx, col_idx, cell_value)

        # Save the modified workbook
        wb.save(file_path)
        print(f"Successfully processed {file_path}")
        return True

    except Exception as e:
        print(f"Error processing .xls file {file_path}: {str(e)}")
        return False

def replace_in_excel(file_path, replacements):
    try:
        print(f"Processing {file_path}...")
        
        # Handle .xls files differently
        if file_path.lower().endswith('.xls'):
            return process_xls_file(file_path, replacements)
            
        # For .xlsx files, use openpyxl
        wb = load_workbook(file_path)
        
        # Process each worksheet
        for ws in wb.worksheets:
            for row in ws.iter_rows():
                for cell in row:
                    if cell.value and isinstance(cell.value, str):
                        # Apply all replacements
                        modified = False
                        value = cell.value
                        for find, replace in replacements.items():
                            if find in value:
                                value = value.replace(find, replace)
                                modified = True
                        if modified:
                            cell.value = value
        
        # Save the workbook
        wb.save(file_path)
        print(f"Successfully processed {file_path}")
        return True
        
    except Exception as e:
        print(f"Error processing {file_path}: {str(e)}")
        return False

def main():
    if len(sys.argv) < 6:
        print("Usage: python replace_excel.py <folder_path> <productID> <productName> <sportType> <betType>")
        sys.exit(1)

    folder_path = sys.argv[1]
    replacements = {
        '{ProductID}': sys.argv[2],
        '{ProductName}': sys.argv[3],
        '{SportType}': sys.argv[4],
        '{BetType}': sys.argv[5]
    }    
    success = True
    for file in os.listdir(folder_path):
        if file.endswith(('.xls', '.xlsx')):
            full_path = os.path.join(folder_path, file)
            if not replace_in_excel(full_path, replacements):
                success = False

    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()