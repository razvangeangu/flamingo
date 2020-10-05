import React, { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { useInjectReducer } from 'redux-injectors';
import { ThemeProvider as OriginalThemeProvider } from 'styled-components';
import { useInjectSaga } from 'utils/redux-injectors';
import { sunsetSunriseSaga } from './saga';
import { selectSunrise, selectSunset, selectTheme } from './selectors';
import { actions, reducer, themeSliceKey } from './slice';
import { saveTheme } from './utils';

export const ThemeProvider = (props: { children: React.ReactChild }) => {
  useInjectReducer({ key: themeSliceKey, reducer: reducer });
  useInjectSaga({ key: themeSliceKey, saga: sunsetSunriseSaga });

  const sunrise = useSelector(selectSunrise);
  const sunset = useSelector(selectSunset);
  const now = new Date();

  useEffect(() => {
    if (now <= new Date(sunrise) || now >= new Date(sunset)) {
      saveTheme('dark');
      dispatch(actions.changeTheme('dark'));
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [sunrise, sunset]);

  const dispatch = useDispatch();
  const useEffectOnMount = (effect: React.EffectCallback) => {
    useEffect(effect, []);
  };
  useEffectOnMount(() => {
    dispatch(actions.loadSunsetSunrise());
  });

  const theme = useSelector(selectTheme);

  return (
    <OriginalThemeProvider theme={theme}>
      {React.Children.only(props.children)}
    </OriginalThemeProvider>
  );
};
