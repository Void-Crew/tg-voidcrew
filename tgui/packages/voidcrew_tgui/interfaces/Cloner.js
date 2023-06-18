import { useBackend } from '../../tgui/backend';
import { Section, ProgressBar } from '../../tgui/components';
import { Window } from '../../tgui/layouts';

export const Cloner = (props, context) => {
  const { act, data } = useBackend(context);

  return (
    <Window width={200} height={150}>
      <Window.Content>
        <Section title="Progress" minheight="50px">
          <ProgressBar
            value={data.progress}
            content={data.progress + '%'}
            maxValue={100}
          />
        </Section>
      </Window.Content>
    </Window>
  );
};
