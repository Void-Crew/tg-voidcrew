import { map } from '../../common/collections';
import { useBackend, useLocalState } from '../../tgui/backend';
import {Box, Button, Divider, Section, Table, Tabs } from '../../tgui/components';
import { Window } from '../../tgui/layouts';

export const VoidcrewManagement = (props, context) => {
  const [tab, setTab] = useLocalState(context, 'tab', 1);
  return (
    <Window title="Voidcrew Management System" width={800} height={600} theme="hackerman">
      <Window.Content scrollable>
        <Tabs>
          <Tabs.Tab selected={tab === 1} onClick={() => setTab(1)}>
            Ships
          </Tabs.Tab>
          <Tabs.Tab selected={tab === 2} onClick={() => setTab(2)}>
            Planets
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && <VoidcrewManagementShips />}
        {tab === 2 && <VoidcrewManagementPlanets />}
      </Window.Content>
    </Window>
  );
};

export const VoidcrewManagementShips = (props, context) => {
  const { act, data } = useBackend(context);
  const ships = data.ships || [];
  return (
    <Section>
      <Table collapsing>
        {ships.map((ship) => (
          <Table.Row key={ship.id}>
            <Table.Cell>
              <Button
                content="JMP"
                key={ship.id}
                onClick={() =>
                  act('jump_to', {
                    type: 'mobile',
                    id: ship.id,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell>
              <Button
                content="VV"
                onClick={() =>
                  act('vv', {
                    ref: ship.ref,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell>
              <Button
                content={ship.docked ? "UNDOCK" : "DOCK"}
                onClick={() =>
                  act('dock', {
                    ref: ship.ref,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell>
              <Button
                content="CTRL"
                onClick={() =>
                  act('control', {
                    ref: ship.ref,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell>
              <Button
                content={ship.locked ? "UNLOCK" : "LOCK"}
                onClick={() =>
                  act('lock', {
                    ref: ship.ref,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell>
              <Button
                content="RECALC"
                onClick={() =>
                  act('recalc', {
                    id: ship.id,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell>{ship.name}</Table.Cell>
            <Table.Cell>{ship.short_name}</Table.Cell>
            <Table.Cell>{ship.status}</Table.Cell>
          </Table.Row>
        ))}
      </Table>
      <Divider />
      <Box>
        <Button
            content="Spawn ship"
            onClick={() =>
              act('spawn', {
                type: 'ship',
              })
            }
          />
        <Button
            content="Toggle Ship Purchasing"
            onClick={() =>
              act('toggle_ship_purchases')
            }
          />
          </Box>
    </Section>
  );
};

export const VoidcrewManagementPlanets = (props, context) => {
  const { act, data } = useBackend(context);
  const planets = data.planets || [];
  return (
    <Section>
      <Table collapsing>
        {planets.map((planet) => (
          <Table.Row key={planet.ref}>
            <Table.Cell>
              <Button
                content="JMP"
                key={planet.ref}
                onClick={() =>
                  act('jump_to', {
                    type: 'planet',
                    ref: planet.ref,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell>
              <Button
                content="VV"
                onClick={() =>
                  act('vv', {
                    ref: planet.ref,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell>
              <Button
                content={planet.loaded ? "UNLOAD" : "LOAD"}
                key={planet.ref}
                onClick={() =>
                  act('load_unload', {
                    type: 'planet',
                    ref: planet.ref,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell>
              <Button
                content={planet.preserved ? "UNPRESERVE" : "PRESERVE"}
                key={planet.ref}
                onClick={() =>
                  act('preserve', {
                    type: 'planet',
                    ref: planet.ref,
                  })
                }
              />
            </Table.Cell>
            <Table.Cell>{planet.name}</Table.Cell>
            <Table.Cell>{planet.loaded ? "Loaded" : "Unloaded"}</Table.Cell>
            <Table.Cell>{planet.preserved ? "Preserved" : "Unpreserved"}</Table.Cell>
          </Table.Row>
        ))}
      </Table>
      <Divider />
      <Box>
        <Button
            content="Spawn planet"
            onClick={() =>
              act('spawn', {
                type: 'planet',
              })
            }
          />
          </Box>
    </Section>
  );
};

