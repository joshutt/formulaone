import unittest

from pickBestTeam import getGrouping

class TestPickTeams(unittest.TestCase) :

    def test_grouping_none_needed(self) :
        currentList = []
        availList = ['a', 'b','c']
        need = 0
        result = getGrouping(availList, need)
        self.assertFalse(result)

    def test_grouping_last_item(self) :
        currentList = ['a']
        availList = ['b','c']
        need = 0
        result = getGrouping(availList, need)
        self.assertFalse(result)


    def test_simple_one(self) :
        availList = ['a']
        need = 1
        result = getGrouping(availList, need)
        self.assertEquals(1, len(result))
        self.assertEquals(['a'], result[0])


    def test_one_result_two_items(self) :
        availList = ['a', 'b']
        need = 1
        result = getGrouping(availList, need)
        #self.assertEquals(3, len(result))
        self.assertEquals([['a'], ['b']], result)

    def test_one_result(self) :
        availList = ['a', 'b', 'c']
        need = 1
        result = getGrouping(availList, need)
        #self.assertEquals(3, len(result))
        self.assertEquals([['a'], ['b'], ['c']], result)
        self.assertEquals(['a'], result[0])
        self.assertEquals(['b'], result[1])
        self.assertEquals(['c'], result[2])


    def test_two_results_only_have_two(self):
        availList = ['a', 'b']
        need =2
        result = getGrouping(availList, need)
        self.assertEquals([['a','b']], result)

    def test_two_results(self):
        availList = ['a', 'b', 'c']
        need =2
        result = getGrouping(availList, need)
        self.assertEquals([['a','b'], ['a','c'], ['b','c']], result)




if __name__ == '__main__' :
    unittest.main()
