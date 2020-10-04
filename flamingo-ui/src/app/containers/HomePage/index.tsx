import { translations } from 'locales/i18n';
import React from 'react';
import { Helmet } from 'react-helmet-async';
import { useTranslation } from 'react-i18next';
import styled from 'styled-components/macro';

const AppName = styled.span`
  align-content: center;
  align-items: center;
  display: flex;
  flex-direction: row;
  height: 100vh;
  justify-content: center;
`;

export function HomePage() {
  const { t } = useTranslation();

  return (
    <>
      <Helmet>
        <title>Home Page</title>
        <meta name="description" content={t(translations.app.quote)} />
      </Helmet>
      <AppName>{t(translations.app.name)}</AppName>
    </>
  );
}
