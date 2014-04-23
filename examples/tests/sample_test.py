import unittest
from sample_class import *

class SampleTest(unittest.TestCase):

    def test_sample_static_method(self):
        result = SampleClass.sample_static_method(5)
        self.assertEqual(result, 11)

    def test_sample_method(self):
        sample = SampleClass()
        result = sample.sample_method(10)
        self.assertEqual(result, 6)

if __name__ == '__main__':
    unittest.main()
