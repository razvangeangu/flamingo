import { createSelector } from '@reduxjs/toolkit';
import { RootState } from 'types';
import { initialState } from './slice';
import { themes } from './themes';
import { isSystemDark } from './utils';

// First select the relevant part from the state
const selectDomain = (state: RootState) => state.theme || initialState;

export const selectSunrise = createSelector(
  [selectDomain],
  theme => theme.sunrise,
);

export const selectSunset = createSelector(
  [selectDomain],
  theme => theme.sunset,
);

export const selectTheme = createSelector([selectDomain], theme => {
  if (theme.selected === 'system') {
    return isSystemDark ? themes.dark : themes.light;
  }
  return themes[theme.selected];
});

export const selectThemeKey = createSelector(
  [selectDomain],
  theme => theme.selected,
);
