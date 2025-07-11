# Etapa 1: imagem base leve com Python
FROM python:3.12-alpine


# Etapa 2: define diretório de trabalho
WORKDIR /app
COPY requirements.txt .

# Etapa 3: evita problemas com output em buffer
ENV PYTHONUNBUFFERED=1

# Etapa 4: instala dependências do sistema (compiladores, etc.)
RUN apk add --no-cache gcc musl-dev libffi-dev sqlite-dev
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: copia arquivos do projeto
COPY . .

# Etapa 6: instala dependências do Python
RUN pip install --upgrade pip \
 && pip install -r requirements.txt

# Etapa 7: expõe a porta da API
EXPOSE 8000

# Etapa 8: comando para rodar o FastAPI com Uvicorn
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]