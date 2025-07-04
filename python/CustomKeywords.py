from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn


class CustomKeywords:
    """Custom Python keywords for Robot Framework that work with Browser Library"""
    
    def __init__(self):
        self.builtin = BuiltIn()
    
    @keyword("Process Search Terms")
    def process_search_terms(self, terms_array):
        """
        Custom keyword that accepts an array and processes each term
        
        Args:
            terms_array: List/array of search terms to process
        """
        # Get Browser library instance
        browser = self.builtin.get_library_instance('Browser')
        
        # Log the received array
        self.builtin.log(f"Received array with {len(terms_array)} terms: {terms_array}")
        
        # Process each term in the array
        for i, term in enumerate(terms_array):
            self.builtin.log(f"Processing term {i+1}: {term}")
            
            # Example: Fill search box and search for each term
            try:
                # Fill the search input
                browser.fill('input[name="q"]', term)
                
                # Press Enter to search
                browser.keyboard_key('Press', 'Enter')
                
                # Wait a bit for results to load
                browser.sleep('2s')
                
                # Log success
                self.builtin.log(f"Successfully searched for: {term}")
                
                # Go back to main Google page for next search
                if i < len(terms_array) - 1:  # Don't go back on last iteration
                    browser.go_to('https://www.google.com')
                    browser.sleep('1s')
                    
            except Exception as e:
                self.builtin.log(f"Error processing term '{term}': {str(e)}", level='WARN')
        
        # Return summary
        return f"Processed {len(terms_array)} search terms successfully"
    
    @keyword("Validate Array Length")
    def validate_array_length(self, array, expected_length):
        """
        Utility keyword to validate array length
        
        Args:
            array: Array to validate
            expected_length: Expected number of elements
        """
        actual_length = len(array)
        
        if actual_length != expected_length:
            raise AssertionError(
                f"Array length mismatch. Expected: {expected_length}, Got: {actual_length}"
            )
        
        self.builtin.log(f"Array length validation passed: {actual_length} elements")
        return True
    
    @keyword("Get Array Element Count")
    def get_array_element_count(self, array):
        """
        Simple keyword that returns the count of elements in array
        
        Args:
            array: Array to count
            
        Returns:
            int: Number of elements in the array
        """
        count = len(array)
        self.builtin.log(f"Array contains {count} elements")
        return count