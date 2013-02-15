"""
Each file that starts with test... in this directory is scanned for subclasses of unittest.TestCase or testLib.RestTestCase
"""

import unittest
import os
import testLib


class TestAdditionalAddUser(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testAddDuplicateUser(self):
        self.makeRequest("/users/add", method="POST", data = { 'user' : 'test1', 'password' : 'password'} )
        respData = self.makeRequest("/users/add", method="POST",
                            data = { 'user' : 'test1', 'password' : 'password'} )
        self.assertResponse(respData, None, -2)

    def testAddUserWithEmptyUsername(self):
        respData = self.makeRequest("/users/add", method="POST",
                            data = { 'user' : '', 'password' : 'password'} )
        self.assertResponse(respData, None, -3)

    def testAddUserWithLongUsername(self):
        respData = self.makeRequest("/users/add", method="POST",
                            data = { 'user' : 'test1'*129, 'password' : 'pass'} )
        self.assertResponse(respData, None, -3)

    def testAddUserWithEmptyPassword(self):
        respData = self.makeRequest("/users/add", method="POST",
                            data = { 'user' : 'test1', 'password' : ''} )
        self.assertResponse(respData, None, -4)

    def testAddUserWithLongPassword(self):
        respData = self.makeRequest("/users/add", method="POST",
                                    data = { 'user' : 'te', 'password' : 'p'*129} )
        self.assertResponse(respData, None, -4)

class TestLoginUser(testLib.RestTestCase):
    """Test adding users"""
    def assertResponse(self, respData, count = 1, errCode = testLib.RestTestCase.SUCCESS):
        expected = { 'errCode' : errCode }
        if count is not None:
            expected['count']  = count
        self.assertDictEqual(expected, respData)

    def testLoginUser(self):
        self.makeRequest("/users/add", method="POST",
                         data = { 'user' : 'test1', 'password' : 'password'} )
        respData = self.makeRequest("/users/login", method="POST",
                                    data = { 'user' : 'test1', 'password' : 'password'} )
        self.assertResponse(respData, 2, 1)

    def testLoginBadUserPasswordInput(self):
        self.makeRequest("/users/add", method="POST",
                         data = { 'user' : 'test1', 'password' : 'password'} )
        respData = self.makeRequest("/users/login", method="POST",
                                    data = { 'user' : 'test1', 'password' : 'password1'} )
        self.assertResponse(respData, None, -1)

    def testLoginBadUserUserNameInput(self):
        self.makeRequest("/users/add", method="POST",
                         data = { 'user' : 'test1', 'password' : 'password'} )
        respData = self.makeRequest("/users/login", method="POST",
                                    data = { 'user' : 'test', 'password' : 'password'} )
        self.assertResponse(respData, None, -1)