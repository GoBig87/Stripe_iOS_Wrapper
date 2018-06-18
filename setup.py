#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
from setuptools import setup, find_packages, Extension


def read(file_path):
    with open(file_path) as fp:
        return fp.read()


setup(
    name='stripe_ios',
    version='0.1',
    description="A simple stripe ios wrapper",
    classifiers=[
        'Development Status :: 1 - Development',
        'Intended Audience :: Developers',
        'Natural Language :: English',
        'Operating System :: iOS',
        'Programming Language :: Objective-C',
        'Programming Language :: Python :: 2.7',
        'Topic :: Finacial :: Payment Processing',
    ],
    keywords=['stripe', 'payment processing'],
    author='GoBig87',
    author_email='add_later@add)later.com',
    url='https://github.com/GoBig87/Stripe_iOS_Wrapper',
    license='BSD',
    packages=find_packages(where='.', exclude=['docs', 'tests']),
    include_package_data=True,
    zip_safe=False,
    setup_requires=[
        'setuptools',
    ],

)
