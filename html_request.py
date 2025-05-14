#!/bin/env python3

import requests
import time 

start_time = time.time()
fails = []

with open('domains_list.txt', 'r') as lista:
    lista = lista.readlines()

for site in lista:
    site = site.strip() #sem o strip fica dando erro de %0a no dominio por causa do \n 
    
    try:
        html = requests.get(f'https://{site}', timeout=2)
        print(site, html)
    except requests.exceptions.RequestException as e:
        print(f"Erro no {site}: {e}")
        fails.append(site)

end_time = time.time()
elapsed_time = end_time - start_time
print(f"\n Script levou {elapsed_time} segundos")
print(f"Dominios que deram errado sao: {fails}")


